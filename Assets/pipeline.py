import os
from PIL import Image

# Quantize an image in `file` filepath and
# stores it in a copy with `_qnt` appended
def qntizeImage(file):
    filename = file[:-4]
    # check if qnt already exists
    if(fileAlreadyExists(filename+"_qnt.png")): return
    # check if its already a quantized 
    if filename.endswith("_qnt"): return
    img = Image.open(str(file))
    # check if its already a opti
    if filename.endswith("_opti"): return
    newImgQNT = img.quantize()
    newImgQNT.save(filename+"_qnt.png",'PNG')

# Optimizes an image in `file` filepath without
# loss and stores a copy with `_opti` appended
def optiImage(file):
    filename = file[:-4]
    # check if opti already exists
    if(fileAlreadyExists(filename+"_opti.png")): return
    # check if its already a quantized
    if filename.endswith("_qnt"): return
    # check if its already a opti
    if filename.endswith("_opti"): return
    os.system("optipng.exe -quiet -out " + filename + "_opti.png " + file)

# Optimizes an image in `file` to use as a texture
# and stores a copy with `.dds` extension
def ddsImage(file):
    filename = file[:-4]
    # check if dds already exists
    if(fileAlreadyExists(filename+".dds")): return
    # check if its already a quantized
    if filename.endswith("_qnt"): return
    # check if its already a opti
    if filename.endswith("_opti"): return
    os.system("texconv.exe " + file)

# Checks if `filepath` file already exists
def fileAlreadyExists(filepath):
    for file in os.listdir("."):
        if file == filepath:
            return True
    return False

# Quintizes, optimizes losslessly and optimizes
# for textures all of the `.png` images in the 
# current directory
print("starting to convert images!...")
for file in os.listdir("."):
    if file.endswith(".png"):
        qntizeImage(file)
        optiImage(file)
        ddsImage(file)
