"""
Usage:
python makePrintableZineFromVirtual.py <filename.pdf> <newfilename.pdf>

This assumes the pages are all of the same size (and specifically does not
bother checking as it only seeks to create new files).
"""

import sys
import copy
from PyPDF2 import PdfWriter, PdfReader, PageObject, Transformation

file = str(sys.argv[1])
newfile = str(sys.argv[2])

# Function to merge two pages side by side
def split_and_merge_pages(page_left, page_right):
    page_left.mediabox.upper_right = (page_left.mediabox.right / 2, page_left.mediabox.top,)

    page_width = page_left.mediabox.width
    page_height = page_left.mediabox.height

    new_left = PageObject.create_blank_page(width = page_width, height = page_height)
    new_left.merge_page(page_left)

    page_right.mediabox.upper_left = (page_right.mediabox.right / 2, page_right.mediabox.top,)

    new_right = PageObject.create_blank_page(width = page_width, height = page_height)
    new_right.merge_page(page_right)
    # Add a translation of 1 width to the right of all contents of merge_page
    new_right.add_transformation(Transformation().translate(tx=-page_width,ty=0))

    # Create a new blank page with double width
    merged_page = PageObject\
            .create_blank_page(width=page_width*2, height=page_height)
    # Merge the right page to the new page
    merged_page.merge_page(new_right)
    # Add a translation of 1 width to the right of all contents of merge_page
    merged_page.add_transformation(Transformation().translate(tx=page_width,ty=0))
    # Merge the left page on the left side of the new page
    merged_page.merge_page(new_left)
    # The new page is ready
    return merged_page

with open(file, "rb") as pdf1:
    pdf = PdfReader(pdf1)
    output = PdfWriter()
    numpages = len(pdf.pages)
    page2skip = 1 # cover

    if numpages % 2 == 1:
        sys.exit("wrong number of pages! add the needed buffers!")

    for i in range(page2skip):
        output.add_page(pdf.pages[i])

    for i in range((numpages - page2skip)//2):
        firstleft = copy.copy(pdf.pages[i + page2skip])
        firstright = copy.copy(pdf.pages[numpages - 1 - i])
        output.add_page(split_and_merge_pages(firstleft, firstright))

        secondleft = copy.copy(pdf.pages[numpages - 1 - i])
        secondright = copy.copy(pdf.pages[i + page2skip])
        output.add_page(split_and_merge_pages(secondleft, secondright))

    output.add_page(pdf.pages[numpages//2]) # middle page

    with open(newfile, "wb") as newpdf:
        output.write(newpdf)

with open(newfile, "rb") as pdf2:
    pdf = PdfReader(pdf2)
    odd_output = PdfWriter()
    even_output = PdfWriter()
    numpages = len(pdf.pages)

    for i in range(numpages):
        if i % 2 == 0:
            odd_output.add_page(pdf.pages[i]) # 0 indexing swaps pages
        else:
            even_output.add_page(pdf.pages[i])


    with open(newfile[:-4] + "_odd.pdf", "wb") as newpdf:
        odd_output.write(newpdf)

    with open(newfile[:-4] + "_even.pdf", "wb") as newpdf:
        even_output.write(newpdf)

with open(newfile[:-4] + "_even.pdf", "rb") as pdf3:
    pdf = PdfReader(pdf3)
    even_reverse_output = PdfWriter()
    numpages = len(pdf.pages)

    for i in range(numpages - 1, -1, -1):
        even_reverse_output.add_page(pdf.pages[i])

    with open(newfile[:-4] + "_even_reversed.pdf", "wb") as newpdf:
        even_reverse_output.write(newpdf)
