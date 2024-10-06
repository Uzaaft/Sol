const vaxis = @import("vaxis");
const colors = @import("../../styles/colors.zig");

const LabelDrawOpts = struct {
    text: []const u8,
    color: vaxis.Color = colors.borderColor,
    y_off: usize = 2,
};

pub fn draw(parent: *vaxis.Window, opts: LabelDrawOpts) !vaxis.Window {
    const window = parent.child(.{});
    _ = try window.printSegment(.{ .text = opts.text, .style = .{ .fg = opts.color } }, .{ .col_offset = opts.y_off });
    return window;
}
