from PIL import ImageFont

font = ImageFont.truetype("Adlam.ttf", 45)  # Change font file and size
letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,/-_"

for letter in letters:
    width = font.getlength(letter)
    print(f"widths.Add('{letter}', {int(width)});")
