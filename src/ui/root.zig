const vaxis = @import("vaxis");
const Panel = @import("panel.zig").Panel;
// const EventsPanel = @import("events-panel.zig");
// const CalendarPanel = @import("calendar-panel.zig");
const Calendar = @import("calendar.zig");

pub const RootDrawOpts = struct {
    activePanel: Panel,
};

pub fn draw(win: *vaxis.Window, opts: RootDrawOpts) !void {
    // try EventsPanel.draw(win, .{ .isActivePanel = opts.activePanel == Panel.events });
    // try CalendarPanel.draw(win, .{ .isActivePanel = opts.activePanel == Panel.calendar });
    _ = opts;
    try Calendar.draw(win);
}
