from kitty.fast_data_types import get_boss
from kitty.tab_bar import draw_title


def draw_tab(draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data):
    manager = get_boss().os_window_map.get(draw_data.os_window_id)
    tabs = manager.tab_bar.last_laid_out_tabs if manager else ()
    count = max(1, len(tabs))
    width, remainder = divmod(max(1, screen.columns), count)
    width = max(1, width + (index <= remainder))
    limit = min(screen.columns, before + width)

    if width < 3:
        screen.draw(' ' * max(0, limit - before))
        return screen.cursor.x

    screen.draw(' ')
    draw_title(draw_data, screen, tab, index, width - 2)
    title_limit = limit - 1
    if screen.cursor.x > title_limit:
        screen.cursor.x = title_limit - 1
        screen.draw('…')
    screen.draw(' ' * max(0, title_limit - screen.cursor.x))
    screen.draw(' ')
    return screen.cursor.x
