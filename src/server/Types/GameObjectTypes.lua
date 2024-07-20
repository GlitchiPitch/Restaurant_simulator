local ServerScriptService = game:GetService("ServerScriptService")
local types = ServerScriptService.Server.Types
local restaurantObjectTypes = require(types.RestaurantObjectTypes)

export type BasicInfo = {
    description: string,
    model: Model | MeshPart,
    image: string,
    name: string,
}

export type Booster = {
    power: string,
}

export type InteractableOrder = {
    clickDetector: ClickDetector,
    onClick: () -> (),
}

export type Order = {
    recipes: {Recipe},
    orderTicket : Model | BasePart,
    orderPlacePoint: Attachment,
    orderingTable: restaurantObjectTypes.TableType,
    waiterPlate: Model | MeshPart,
    spawnOrder: () -> (),
    addDishToBar: (waiterPlate: MeshPart & {Attachment}, recipeIndex: number) -> (),
}

export type Ingredient = BasicInfo & {
    cost: number,
}

export type Recipe = BasicInfo & {
    level: string,
    country: string,
    ingredients: {
        {
            amount: number,
            ingredient: Ingredient,
            cookAction: {string},
        }
    },
}

export type Recipes = {
    common: {Recipe},
    uncommon: {Recipe},
    rare: {Recipe},
    epic: {Recipe},
    legendary: {Recipe},
}

export type UsableItem = Model & {
    RigidConstraint: RigidConstraint,
}

function newRecipe(recipe: Recipe) : Recipe
    return table.freeze({
        description = recipe.description,
        ingredients = recipe.ingredients,
        country     = recipe.country,
        image       = recipe.image,
        level       = recipe.level,
        model       = recipe.model,
        name        = recipe.name,
    })
end

function newIngredient(ingredient: Ingredient) : Ingredient
    return table.freeze({
        description = ingredient.description,
        model       = ingredient.model,
        image       = ingredient.image,
        name        = ingredient.name,
        cost        = ingredient.cost,
    }) 
end


return {
    newRecipe = newRecipe,
    newIngredient = newIngredient,
}