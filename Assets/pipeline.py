import os
from PIL import Image

def qntizeImage(file):
    filename = file[:-4]
    # check if qnt already exists
    if(fileAlreadyExists(filename+"_qnt.png")): return
    # check if its already a quantized 
    if filename.endswith("_qnt"): return
    img = Image.open(str(file))
    newImgQNT = img.quantize()
    newImgQNT.save(filename+"_qnt.png",'PNG')

def optiImage(file):
    filename = file[:-4]
    # check if opti already exists
    if(fileAlreadyExists(filename+"_opti.png")): return
    # check if its already a quantized
    if filename.endswith("_qnt"): return
    # check if its already a opti
    if filename.endswith("_opti"): return
    os.system("optipng.exe -quiet -out " + filename + "_opti.png " + file)

def ddsImage(file):
    filename = file[:-4]
    # check if dds already exists
    if(fileAlreadyExists(filename+".dds")): return
    # check if its already a quantized
    if filename.endswith("_qnt"): return
    # check if its already a opti
    if filename.endswith("_opti"): return
    os.system("texconv.exe " + file)

def fileAlreadyExists(filepath):
    for file in os.listdir("."):
        if file == filepath:
            return True
    return False

print("starting to convert images!...")
for file in os.listdir("."):
    if file.endswith(".png"):
        qntizeImage(file)
        optiImage(file)
        ddsImage(file)
