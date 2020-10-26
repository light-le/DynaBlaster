from PIL import Image, ImageFont, ImageDraw

orimon = Image.open('monsters.gif').convert('RGBA')

im_w = orimon.size[0]
im_h = orimon.size[1]

tile_w = 17
tile_h = 19

mon_w = 16
mon_h = 18

# font = ImageFont.truetype("../fonts/font.ttf", 16)

for mon in range(53):
    # print(mon)
    mon_x = (mon % 46)*tile_w
    mon_y = (mon // 46)*tile_h

    mask = mon + 53
    mask_x = (mask % 46)*tile_w
    mask_y = (mask // 46)*tile_h

    mon_im = orimon.crop((mon_x, mon_y, mon_x + mon_w, mon_y + mon_h))
    mask_im = orimon.crop((mask_x, mask_y, mask_x + mon_w, mask_y + mon_h)).convert('L')

    mon_im.putalpha(mask_im)
    # mon_im = ImageDraw.Draw(mon_im)
    # mon_im.text((0, 0), str(mon), font=font, fill=(17, 50, 132, 255))

    orimon.paste(mon_im, (mon_x, mon_y, mon_x + mon_w, mon_y + mon_h))

orimon.save('monsters.png', 'png')
print('done')

