from PIL import Image, ImageFont, ImageDraw

orimon = Image.open('tiles.png')
oridraw = ImageDraw.Draw(orimon)

im_w = orimon.size[0]
im_h = orimon.size[1]

tile_w = 17
tile_h = 17

mon_w = 16
mon_h = 16

font = ImageFont.truetype("../fonts/font.ttf", 12)

for mon in range(138):
    # print(mon)
    mon_x = (mon % 46)*tile_w
    mon_y = (mon // 46)*tile_h

    oridraw.text((mon_x, mon_y), str(mon+1), font = font, fill = '#ffffff', stroke_width=1, stroke_color='#000000')

orimon.save('tiles_numbered.png', 'PNG')