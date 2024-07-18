
local admin = {
    {
        {
            name = 'admin1',
            model = 'M',
            description = 'This is admin',
        },

        {
            name = 'admin2',
            model = 'M',
            description = 'This is admin',
        },
    },
    
    {
        {
            name = 'admin3',
            model = 'M',
            description = 'This is admin',
        },
    },

    {
        {
            name = 'admin4',
            model = 'M',
            description = 'This is admin',
        },
    },
}

local hostess = {
    {
        {
            name = 'Hostess1',
            model = 'M',
            description = 'This is admin',
        },

        {
            name = 'Hostess2',
            model = 'M',
            description = 'This is admin',
        },
    },

    {
        {
            name = 'Hostess3',
            model = 'M',
            description = 'This is admin',
        },
    },

    {
        {
            name = 'Hostess4',
            model = 'M',
            description = 'This is admin',
        },
    },
}

local courier = {
    {
        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },

        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },
    },

    {
        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },
    },

    {
        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },
    },  
}

local cook = {
    {
        {
            name = 'cook1',
            model = 'M',
            description = 'This is cook',
        },
        
        {
            name = 'cook2',
            model = 'M',
            description = 'This is cook',
        },
    },

    {
        {
            name = 'cook3',
            model = 'M',
            description = 'This is cook',
        },
    },

    {
        {
            name = 'cook4',
            model = 'M',
            description = 'This is cook',
        },
    },
}

local waiter = {
    {
        {
            name = 'waiter1',
            model = 'M',
            description = 'This is waiter',
        },

        {
            name = 'waiter2',
            model = 'M',
            description = 'This is waiter',
        },
    },
    {
        {
            name = 'waiter3',
            model = 'M',
            description = 'This is waiter',
        },
    },

    {
        {
            name = 'waiter4',
            model = 'M',
            description = 'This is waiter',
        },
    },
}

local handyman = {
    {
        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },

        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },
    },

    {
        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },
    },

    {
        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },
    },
}

local critic = {
    {
        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },
        
        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },

        {
            name = 'RightHand',
            model = 'M',
            description = 'This is admin',
        },
    }
}

local citizen = {
    { -- common
        {
            name = 'CommonClient1',
            model = 'M',
        },

        {
            name = 'CommonClient2',
            model = 'W',
        },

        {
            name = 'CommonClient3',
            model = 'M',
        },

        {
            name = 'CommonClient4',
            model = 'M',
        },
    },
}


local vip = {
    { -- vip
        {
            name = 'Vip',
            model = 'M',
            description = '',
        },

        {
            name = 'Vip',
            model = 'M',
            description = '',
        },
    }
}

local client = table.clone(citizen)

local defaultImages = {
    admin = {
        M = {'', '', '',},
        W = {'', '', '',},
    },
    hostess = {
        M = {'', '', '',},
        W = {'', '', '',},
    },
    courier = {
        M = {'', '', '',},
        W = {'', '', '',},
    },
    cook = {
        M = {'', '', '',},
        W = {'', '', '',},
    },
    waiter = {
        M = {'', '', '',},
        W = {'', '', '',},
    },
    handyman = {
        M = {'', '', '',},
        W = {'', '', '',},
    },
    critic = {
        M = {'', '', '',},
        W = {'', '', '',},
    },
    citizen = {
        M = {'', '', '',},
        W = {'', '', '',},
    },
    client = {
        M = {'', '', '',},
        W = {'', '', '',},
    },
}

return {
    handyman    = handyman,
    hostess     = hostess,
    citizen     = citizen,
    courier     = courier,
    client      = client,
    waiter      = waiter,
    critic      = critic,
    admin       = admin,
    cook        = cook,
    vip         = vip,

    defaultImages = defaultImages,
}