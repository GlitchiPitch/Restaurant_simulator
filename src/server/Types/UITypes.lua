
function newImage(image: string?, defaultImage: string?): string
	return image or defaultImage or 'rbxassetid://0'
end

function newIngredientImage(image: string?): string
	return newImage(image, 'rbxassetid://17016080775')
end

function newRecipeImage(image: string?): string
	return newImage(image, 'rbxassetid://17719256229')
end

return {
    newImage            = newImage,
    newRecipeImage      = newRecipeImage,
    newIngredientImage  = newIngredientImage,
}