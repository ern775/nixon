"""Default file for Steam game fixes
This file is always executed for games that are identified as Steam games,
even if no game fix is present. It is run before game fixes are applied.
"""

import sys
from protonfixes import util


def main() -> None:
    """Global defaults"""

    # Steam commandline
    def use_steam_commands() -> None:
        """Parse aliases from Steam launch options"""
        pf_alias_list = list(filter(lambda item: item.startswith('-pf_'), sys.argv))

        for pf_alias in pf_alias_list:
            alias, sep, param = pf_alias.partition('=')
            if sep != '=':
                continue
            sys.argv.remove(pf_alias)

            if alias == '-pf_tricks':
                util.protontricks(param)
            elif alias == '-pf_dxvk_set':
                dxvk_opt, dxvk_sep, dxvk_val = param.partition('=')
                if dxvk_sep == '=':
                    util.set_dxvk_option(dxvk_opt, dxvk_val)
            elif alias == '-pf_replace_cmd':
                repl_opt, repl_sep, repl_val = param.partition('=')
                if repl_sep == '=':
                    util.replace_command(repl_opt, repl_val)

    use_steam_commands()

    import importlib.util
    log_path = f"{util.protondir()}/protonfixes/logger.py"
    log_spec = importlib.util.spec_from_file_location("logger", log_path)
    log_module = importlib.util.module_from_spec(log_spec)
    log_spec.loader.exec_module(log_module)
    log = log_module.log

    if any(game in sys.argv[2] for game in ["GenshinImpact", "ZenlessZoneZero"]):
        try:
            # For getting the official fix from umu-protonfixes
            umu_genshin_path = f"{util.protondir()}/protonfixes/gamefixes-umu/umu-genshin.py"
            umu_genshin_spec = importlib.util.spec_from_file_location("umu-genshin", umu_genshin_path)
            umu_genshin_module = importlib.util.module_from_spec(umu_genshin_spec)
            umu_genshin_spec.loader.exec_module(umu_genshin_module)
            log.info("Global umu-genshin protonfix found for current proton")
            util.set_environment('WINE_ENABLE_TIMEOUT_FIX', '1')
            umu_genshin_module.main()
        except FileNotFoundError:
            log.warn("No umu-genshin protonfix found for current proton, falling back to UMU_USE_STEAM")
            util.set_environment('WINE_ENABLE_TIMEOUT_FIX', '1')
            util.set_environment('UMU_USE_STEAM', '1')
            util.set_environment('WINE_DISABLE_VULKAN_OPWR', '1')

    # # All around fix for mouse dropping inputs, same setting can be set by adding `"UseTakeFocus"="N"` under `[Software\\Wine\\X11 Driver]` in the `user.reg` file
    # if ("GenshinImpact" in sys.argv[2]) or ("StarRail" in sys.argv[2]):
    #     log.info("Unity game found, enabling fix for mouse inputs")
    #     util.regedit_add(
    #         'HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver',
    #         'UseTakeFocus',
    #         'REG_SZ',
    #         'N',
    #     )
