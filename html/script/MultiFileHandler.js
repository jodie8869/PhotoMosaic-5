/****
 *   Constructor
 */
function MultiFileHandler(/* [node1, node2, ...], [fn1, fn2, ...] */) {
	console.log(arguments);
	this.files = [];

	this.nodes = [].slice.call(arguments[0]);
	this.callbacks = [].slice.call(arguments[1]);

	this._init();
}

MultiFileHandler.prototype = {
	_init: function() {
		if (window.File
				&& window.FileList
				&& window.FileReader
				&& window.Blob) {
		} else {
			console.log("Browser doesn't support full range of File API");
			return ;
		}

		if (this.nodes.length <= 0) {
			return ;
		}

		this._initEvents(this.nodes);
	},

	_initEvents: function(nodes) {
		nodes.forEach(function(node) {
			if (node == null) {
				return ;
			}

			if (node.nodeName === "INPUT") {
				node.addEventListener("change",
						this._fileSelectHandler.bind(this));
			} else {
				node.addEventListener("dragover", this._fileDragHover);
				node.addEventListener("dragleave", this._fileDragHover);
				node.addEventListener("drop",
						this._fileSelectHandler.bind(this));
			}
		}.bind(this));
	},

	_fileDragHover: function(event) {
		event.stopPropagation();
		event.preventDefault();

		if (event.type == "dragover") {
			event.dataTransfer.dropEffect = "copy"; 
			event.target.appendClassName("hover");
		} else {
			event.target.removeClassName("hover");
		}
	},

	_fileSelectHandler: function(event) {
		// cancel event and hover styling
		this._fileDragHover(event);

		// fetch FileList object
		var files = event.target.files || event.dataTransfer.files;

		// process all File objects
		for (var idxFile = 0, file; file = files[idxFile]; idxFile++) {
			this.files.push(file);
			for (var idxCb = 0, cb; cb = this.callbacks[idxCb]; idxCb++) {
				cb(file);
			}
		}
	},

	getFiles: function() {
		return this.files;
	}

}

