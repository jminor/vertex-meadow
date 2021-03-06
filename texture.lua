local texture = {}

function texture.read_texture(color_filename, filter)
    filter = filter or "linear"
    local color_image = am.load_image(color_filename)
    --[[
    local heightmap_image = am.load_image(heightmap_filename)
    if color_image.width ~= heightmap_image.width then
        error(string.format("%s and %s have different widths (%d vs %d)",
            color_filename, heightmap_filename, color_image.width, heightmap_image.width))
    end
    if color_image.height ~= heightmap_image.height then
        error(string.format("%s and %s have different heights (%d vs %d)",
            color_filename, heightmap_filename, color_image.height, heightmap_image.height))
    end
    local alpha_view = color_image.buffer:view("ubyte", 3, 4)
    local depth_view = heightmap_image.buffer:view("ubyte", 0, 4)
    alpha_view:set(depth_view)
    ]]
    local texture = am.texture2d(color_image)
    texture.wrap = "mirrored_repeat"
    texture.filter = filter
    return {
        tex = texture,
        img = color_image,
        fb = am.framebuffer(texture)
    }
end

function texture.read_hand_texture(filename, filter)
    filter = filter or "linear"
    local image = am.load_image(filename)
    local texture = am.texture2d(image)
    texture.filter = filter
    return {
        tex = texture,
        img = image,
        fb = am.framebuffer(texture)
    }
end

return texture
