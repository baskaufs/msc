# pillow module tutorial https://pillow.readthedocs.io/en/stable/handbook/tutorial.html#geometrical-transforms
from PIL import Image

# piexif notes https://pypi.org/project/piexif/
import piexif

import os

# This is to help me remember how to list all of the tags found in an image
# The exif_dict is a dictionary of dictionaries of dictionaries
# The ifd tuple of tag types (parts of first subdictionary) are sections in the embedded metadata
# The second level subdictionary have number keys, e.g. 274 is the code for the orientation setting
'''
for ifd in ("0th", "Exif", "GPS", "1st"):
    print(ifd)
    for tag in exif_dict[ifd]:
        print(tag, piexif.TAGS[ifd][tag]["name"], exif_dict[ifd][tag])
'''
    
def rotate_image(imageName, inDirectory, outDirectory):
    im = Image.open(inDirectory + '/' + imageName)
    exif_dict = piexif.load(im.info["exif"])

    # diagram on rotations at https://www.daveperrett.com/articles/2012/07/28/exif-orientation-handling-is-a-ghetto/
    if exif_dict["0th"][274] != 1: # rotate any image that's not already unrotated
        # perform a hard rotation to the correct orientation
        if exif_dict["0th"][274] == 6:
            out = im.transpose(Image.ROTATE_270)
        elif exif_dict["0th"][274] == 8:
            out = im.transpose(Image.ROTATE_90)
        elif exif_dict["0th"][274] == 3:
            out = im.transpose(Image.ROTATE_180)

        # change image orientation setting from rotated to unrotated
        exif_dict["0th"][274] = 1
        exif_bytes = piexif.dump(exif_dict)
        out.save(outDirectory + '/' + imageName, "jpeg", exif=exif_bytes)

# ***** main script **************

# the input and output directories must be subdirectories of the directory from which the script is run
inputSubdirectory = 'in'
outputSubdirectory = 'out'
# hacked from https://stackoverflow.com/questions/11968976/list-files-only-in-the-current-directory
files = [f for f in os.listdir('./' + inputSubdirectory) if os.path.isfile(os.path.join('./' + inputSubdirectory, f))]
for file in files:
    print(file) # print the file being processed so you can see it's doing something
    rotate_image(file, inputSubdirectory, outputSubdirectory)
