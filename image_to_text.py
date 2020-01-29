from PIL import Image
import pytesseract as tesseract
from pytesseract import image_to_string

# "/Users/kprovost/Dropbox (AMNH)/Dissertation/CHAPTER3_TRAITS/Distances/GDM_results/univariate/ALL_MORPH/ONLY_VARIABLE/BELLII/BEL_ABUN_splines_allmorph.png" 

print(image_to_string(Image.open('/Users/kprovost/Dropbox (AMNH)/Dissertation/CHAPTER3_TRAITS/Distances/GDM_results/univariate/ALL_MORPH/ONLY_VARIABLE/BELLII/BEL_ABUN_splines_allmorph.png')))
print(image_to_string(Image.open('test-english.jpg'), lang='eng'))