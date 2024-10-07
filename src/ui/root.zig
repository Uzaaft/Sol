const vaxis = @import("vaxis");
const Panel = @import("panel.zig").Panel;
const VerticalSplitLayout = @import("./components/vertical-split-layout.zig");
const EventsPanel = @import("events-panel.zig");
const CalendarPanel = @import("calendar-panel.zig");
const GridPosition = @import("../types/grid-position.zig").GridPosition;

pub const RootDrawOpts = struct {
    activePanel: Panel,
    calendarCursorPosition: GridPosition = .{ .x = 0, .y = 0 },
};

pub fn draw(win: *vaxis.Window, opts: RootDrawOpts) !void {
    var container = VerticalSplitLayout.draw(win);

    _ = try EventsPanel.draw(&container.left, .{ .isActivePanel = opts.activePanel == Panel.events });
    _ = try CalendarPanel.draw(&container.right, .{
        .isActivePanel = opts.activePanel == Panel.calendar,
        .calendarCursorPosition = opts.calendarCursorPosition,
    });
}
