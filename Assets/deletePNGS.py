# deletePNGS.py
import os

print("starting to delete images!...")
for file in os.listdir("."):
    if file.endswith(".png"):
        print(file)
        filename = file[:-4]
        if filename.endswith("_qnt"):
            os.remove(file)
        if filename.endswith("_opti"):
            os.remove(file)
    if file.endswith(".DDS"):
        os.remove(file)
