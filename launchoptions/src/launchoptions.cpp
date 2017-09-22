#define LIB_NAME "launchoptions_utils"
#define MODULE_NAME "launchoptions_utils"
#define DLIB_LOG_DOMAIN "launchoptions_utils"

#include <dmsdk/sdk.h>
#include "launchoptions.h"

static int LuaHideWindow(lua_State* L)
{
    launchoptions_platform::HideWindow();
    return 0;
}

static int LuaShowWindow(lua_State* L)
{
    launchoptions_platform::ShowWindow();
    return 0;
}

static int LuaMakeDialog(lua_State* L)
{
    launchoptions_platform::MakeDialog();
    return 0;
}

static int LuaSetWindowSize(lua_State* L)
{
    int w = luaL_checkint(L, 1);
    int h = luaL_checkint(L, 2);
    launchoptions_platform::SetWindowSize((float)w, (float)h);
    return 0;
}

static void LuaInit(lua_State* L)
{
    int top = lua_gettop(L);

    const luaL_reg Module_methods[] =
    {
        {"hide_window", LuaHideWindow},
        {"show_window", LuaShowWindow},
        {"make_dialog", LuaMakeDialog},
        {"set_window_size", LuaSetWindowSize},
        {0, 0}
    };
    luaL_register(L, MODULE_NAME, Module_methods);

    lua_pop(L, 1);
    assert(top == lua_gettop(L));
}

dmExtension::Result LaunchOptions_AppInitialize(dmExtension::AppParams* params)
{
    return dmExtension::RESULT_OK;
}

dmExtension::Result LaunchOptions_Initialize(dmExtension::Params* params)
{
    LuaInit(params->m_L);
    launchoptions_platform::Init();
    return dmExtension::RESULT_OK;
}

dmExtension::Result LaunchOptions_AppFinalize(dmExtension::AppParams* params)
{
    return dmExtension::RESULT_OK;
}

dmExtension::Result LaunchOptions_Finalize(dmExtension::Params* params)
{
    return dmExtension::RESULT_OK;
}


// Defold SDK uses a macro for setting up extension entry points:
//
// DM_DECLARE_EXTENSION(symbol, name, app_init, app_final, init, update, on_event, final)

DM_DECLARE_EXTENSION(launchoptions_utils, LIB_NAME, LaunchOptions_AppInitialize, LaunchOptions_AppFinalize, LaunchOptions_Initialize, 0, 0, LaunchOptions_Finalize)
