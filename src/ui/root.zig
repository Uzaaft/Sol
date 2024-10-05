const vaxis = @import("vaxis");
const Panel = @import("panel.zig").Panel;
const EventsPanel = @import("events-panel.zig");
const CalendarPanel = @import("calendar-panel.zig");

pub const RootDrawOpts = struct {
    activePanel: Panel,
};

pub fn draw(win: *vaxis.Window, opts: RootDrawOpts) void {
    EventsPanel.draw(win, .{ .isActivePanel = opts.activePanel == Panel.events });
    CalendarPanel.draw(win, .{ .isActivePanel = opts.activePanel == Panel.calendar });
}
