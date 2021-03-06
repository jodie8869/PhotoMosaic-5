package ppomo.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ppomo.algorithm.generator.MosaicImageGenerator;
import ppomo.dao.MosaicDao;
import ppomo.dao.PhotoDao;
import ppomo.domain.support.DataURL;
import ppomo.domain.table.Mosaic;
import ppomo.domain.table.Photo;
import ppomo.domain.table.User;
import ppomo.support.Constants;
import ppomo.support.StringHandler;

@Service
public class MosaicService {
	private static final Logger logger = LoggerFactory.getLogger(MosaicService.class);

	@Autowired
	MosaicDao mosaicDao;
	
	@Autowired
	PhotoDao photoDao;

	@Autowired
	UploadService uploadService;

	@Autowired
	UserService userService;
	
	@Autowired
	PhotoService photoService;
	
	
	public String createMosaicInClient(MultipartFile[] files, String title, String comment, String clientMosaic,  HttpSession session, String[] resizedDataURLs) {
		return createMosaic(files, title, comment, clientMosaic, session, resizedDataURLs, false);
	}
	
	public String createMosaicInServer(MultipartFile[] files, String title, String comment, String clientMosaic, HttpSession session, String[] resizedDataURLs) {
		return createMosaic(files, title, comment, clientMosaic, session, resizedDataURLs, true);
	}
	
	private String createMosaic(MultipartFile[] files, String title, String comment, String clientMosaic, HttpSession session, String[] resizedDataURLs, boolean server) {
		Mosaic mosaic = createMosaicInstance(title, comment, session);
		//Photo[] photoArr = uploadService.uploadMultipartFiles(files, mosaic);
		
		/*서버에서 사이즈 줄일경우 이 부분 삭제 */
		List<DataURL> dataUrlList = new ArrayList<DataURL>();
		
		for (String dataURL : resizedDataURLs) {
			dataUrlList.add(DataURL.create(dataURL));
		}
		
		Photo[] photoArr = uploadService.uploadDataUrlList(dataUrlList, mosaic);
		/* 삭제 끝 */
		
		mosaic.setPhotos(photoArr);
		
		String mosaicPath = Constants.ATTACHMENT_ROOT_DIR + File.separator + mosaic.getId() +File.separator + mosaic.getFileName();
		
		if( server ) {
			MosaicImageGenerator mosaicImageGenerator = new MosaicImageGenerator(mosaic);
			try {
				mosaicImageGenerator.makeMosaicImage();
			} catch (IOException e1) {
				logger.error("exception in createMosaic of server : " + e1.getMessage());
			}
		
		} else {
			uploadService.uploadMosaicUrl(new DataURL(clientMosaic), mosaicPath);
		}
		mosaicDao.updateCreatedTime(mosaic);
        mosaic.setCreatedDate(mosaicDao.getCreatedTime(mosaic.getId()));
        return mosaic.getUrl();	
	}

	//tx를 걸면, rollback할 시, autoincrement는 rollback이 안될수도 있어. 그래서 조심해야되. 1357만 남을수 있으니까. 
	//그러니까 아이디가 10이라고 갯수가 10개가 아닐 수도 있어. 
	//pk는 하나인게 좋아. 자연키(비지니스적 의미가 있기 때문에 변할 수 있어), 대리키. 중에 대리키를 pk로 하는 것이 더 편해. 
	//왜냐면, pk는 몇가지 규칙이 있어. 그중 하나는 변하면 안되는게 있는데, 자연키는 비지니스 의미가 있기 때문에, 변할 수가 있어. 그래서 대리키가 pk로 더 좋아. 
	private Mosaic createMosaicInstance(String title, String comment, HttpSession session) {
		User currentUser = userService.getCurrentUser(session);
		
		Mosaic mosaic = createAndUploadMosaic(title, comment);
		updateUserInfoOnMosaic(currentUser, mosaic);
		
		return mosaic;
	}
	
	private Mosaic createAndUploadMosaic(String title, String comment){
		String mosaicUrl = StringHandler.makeUrl();
		Mosaic mosaic = createMosaicObject(mosaicUrl, title, comment);
		uploadMosaicObject(mosaic);
		setIdOnMosaic(mosaicUrl, mosaic);
		return mosaic;
	}
	
	private Mosaic createMosaicObject(String mosaicUrl, String title, String comment){
		return new Mosaic(mosaicUrl + "."+ Constants.MOSAIC_FILE_EXTENSION, title, mosaicUrl,comment);
	}
	
	private void uploadMosaicObject(Mosaic mosaic){
		mosaicDao.upload(mosaic);
	}
	
	private void setIdOnMosaic(String mosaicUrl, Mosaic mosaic){
		int mosaicId = mosaicDao.findByUrl(mosaicUrl).getId();
		mosaic.setId(mosaicId);
	}
	
	private void updateUserInfoOnMosaic(User currentUser, Mosaic mosaic){
		if (currentUser != null) {
			int currentUserId = currentUser.getId();
			mosaic.setUserId(currentUserId);
			mosaicDao.updateUserId(mosaic);
		}
	}
	
	public Mosaic showResultOfAMosaic(String uniqueUrl){
		
		Mosaic theMosaic = getSpecificMosaic(uniqueUrl);
		Photo[] mosaicPhotos = getPhotosOfAMosaic(theMosaic);
		setPhotosOnMosaic(theMosaic, mosaicPhotos);
		
		return theMosaic;
	}
	
	private Mosaic getSpecificMosaic(String uniqueUrl){
		Mosaic theMosaic = mosaicDao.findByUrl(uniqueUrl);
		return theMosaic;
	}
	
	private Photo[] getPhotosOfAMosaic(Mosaic mosaic){
		List<Photo> photos = photoDao.findPhotosOfMosaic(mosaic.getId());
		Photo[] mosaicPhotos = new Photo[photos.size()];
		for(int i = 0; i < photos.size(); ++i){
			mosaicPhotos[i] = photos.get(i);
		}
		return mosaicPhotos;
	}

	private void setPhotosOnMosaic(Mosaic mosaic, Photo[] photos){
		mosaic.setPhotos(photos);
	}
}