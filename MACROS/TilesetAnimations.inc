
structTilesetAnimationFrame .struct Graphics, Destination, Framecount
	.long \Graphics
	.word \Destination / 2
	.byte \Framecount
	.ends

structTilesetAnimationEnd .struct
	.long None
	.ends
