package org.nhnnext.generator;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.imageio.ImageIO;

import org.nhnnext.domains.Mosaic;
import org.nhnnext.domains.Photo;
import org.nhnnext.dto.Container;
import org.nhnnext.dto.PhotoContainer;
import org.nhnnext.dto.PhotoGroupContainer;
import org.nhnnext.dto.Template;
import org.nhnnext.dto.TemplateFrameList;
import org.nhnnext.support.Constants;
import org.nhnnext.support.Orientation;
import org.nhnnext.support.UploadHandler;

public class MosaicImageGenerator {

	private PhotoGroupContainer groupContainer; 
	private Orientation basePhotoOrientation;
	private TemplateFrameList templateFrameList;
	private Mosaic mosaic;
	
	public MosaicImageGenerator(Mosaic mosaic) {
		
		init(mosaic);
		setupContainer();
		placePhotosToContainer(mosaic.getPhotos());
	}

	protected void init(Mosaic mosaic) {
		this.mosaic = mosaic;
		Orientation mosaicOrientation = mosaic.getOrientation();
		Template template = Template.getRandomTemplate(mosaicOrientation);
		this.templateFrameList = template.getTemplateFrameList();
		//Get CriteriaOrientation, 
		this.basePhotoOrientation = Orientation.getBasePhotoOrientation(mosaicOrientation);
	}

	private void setupContainer() {
		ContainerGenerator containerGenerator = new ContainerGenerator(templateFrameList);
		this.groupContainer = containerGenerator.getContainer();
	}
	
	private void placePhotosToContainer(Photo[] originPhotos) {
		
		ArrayList<Photo> originPhotoList = new ArrayList<Photo>(Arrays.asList(originPhotos));
		PhotoContainer criteriaPhotoList = new PhotoContainer(this.templateFrameList.size());
		
		//Seperate PhotoList (criteria and others)
		for (Photo photo : originPhotos) {
			if (photo.getOrientation() == basePhotoOrientation) {
				criteriaPhotoList.add(photo);
				originPhotoList.remove(photo);
			}
		}
		
		//Placement
		for (int index = 0; index < this.groupContainer.size(); index++) {
			PhotoContainer photoContainer = this.groupContainer.get(index);
			
			if (!criteriaPhotoList.isEmpty())
				photoContainer.add(criteriaPhotoList.remove(index));
			
			while(!photoContainer.isFull()) {
				photoContainer.add(originPhotoList.remove(index));
			}
		}
		
		//TODO
		//Something Wrong
		//if (originPhotoList.size() !=0 || criteriaPhotoList.size() != 0)
		//		throw new Exception();	
	}

	public void makeMosaicImage() throws IOException {
		BufferedImage mosaicImage = groupContainer.getCombinedMosaic(mosaic, basePhotoOrientation);
		File file = new File(Constants.ATTACHMENT_ROOT_DIR + File.separator + mosaic.getId() + mosaic.getFileName());
		ImageIO.write(mosaicImage, Constants.MOSAIC_FILE_EXTENSION, file);
	}
}
