const vaxis = @import("vaxis");
const Panel = @import("panel.zig").Panel;
const VerticalSplitLayout = @import("./components/vertical-split-layout.zig");
const EventsPanel = @import("events-panel.zig");
const CalendarPanel = @import("calendar-panel.zig");

pub const RootDrawOpts = struct {
    activePanel: Panel,
};

pub fn draw(win: *vaxis.Window, opts: RootDrawOpts) !void {
    var container = VerticalSplitLayout.draw(win);

    _ = try EventsPanel.draw(&container.left, .{ .isActivePanel = opts.activePanel == Panel.events });
    _ = try CalendarPanel.draw(&container.right, .{ .isActivePanel = opts.activePanel == Panel.calendar });
}
