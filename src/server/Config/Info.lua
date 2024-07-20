local COUNTRY = table.freeze({
	panasia		= 'panasia', -- паназия
	europe		= 'europe', -- европа
	russia		= 'russia', -- россия
	italy		= 'italia', -- италия
	caucasus	= 'caucasus', -- кавказ
})

local COOK_ACTIONS = {
	slicing = 'slicing',
	boiling = 'boiling',
	washing = 'washing',
	mixing 	= 'mixing',
	frying 	= 'frying',
}

return {
    COUNTRY = COUNTRY,
	COOK_ACTIONS = COOK_ACTIONS,
}