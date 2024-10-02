const std = @import("std");
const vaxis = @import("vaxis");

pub const panic = vaxis.panic_handler;

pub const std_options: std.Options = .{
    .log_scope_levels = &.{
        .{ .scope = .vaxis, .level = .warn },
        .{ .scope = .vaxis_parser, .level = .warn },
    },
};

const Event = union(enum) {
    key_press: vaxis.Key,
    key_release: vaxis.Key,
    mouse: vaxis.Mouse,
    focus_in,
    focus_out,
    paste_start,
    paste_end,
    paste: []const u8,
    color_report: vaxis.Color.Report,
    color_scheme: vaxis.Color.Scheme,
    winsize: vaxis.Winsize,
};

pub const App = struct {
    allocator: std.mem.Allocator,
    should_quit: bool,
    tty: vaxis.Tty,
    vx: vaxis.Vaxis,
    mouse: ?vaxis.Mouse,

    pub fn init(allocator: std.mem.Allocator) !App {
        return .{
            .allocator = allocator,
            .should_quit = false,
            .tty = try vaxis.Tty.init(),
            .vx = try vaxis.init(allocator, .{}),
            .mouse = null,
        };
    }

    pub fn deinit(self: *App) void {
        self.vx.deinit(self.allocator, self.tty.anyWriter());
        self.tty.deinit();
    }

    pub fn run(self: *App) !void {
        var loop: vaxis.Loop(Event) = .{
            .tty = &self.tty,
            .vaxis = &self.vx,
        };

        try loop.init();
        try loop.start();

        try self.vx.enterAltScreen(self.tty.anyWriter());

        try self.vx.queryTerminal(self.tty.anyWriter(), 1 * std.time.ns_per_s);

        try self.vx.setMouseMode(self.tty.anyWriter(), true);

        while (!self.should_quit) {
            loop.pollEvent();
            while (loop.tryEvent()) |event| {
                try self.update(event);
            }
            self.draw();

            var buffered = self.tty.bufferedWriter();
            try self.vx.render(buffered.writer().any());
            try buffered.flush();
        }
    }

    pub fn update(self: *App, event: Event) !void {
        switch (event) {
            .key_press => |key| {
                if (key.matches('c', .{ .ctrl = true }))
                    self.should_quit = true;
                if (key.matches('q', .{}))
                    self.should_quit = true;
            },
            .mouse => |mouse| self.mouse = mouse,
            .winsize => |ws| try self.vx.resize(self.allocator, self.tty.anyWriter(), ws),
            else => {},
        }
    }

    pub fn draw(self: *App) void {
        const msgLine1 = "         ☀  Sol         ";
        const msgLine2 = "A TUI for Apple calendar";
        const msg = msgLine1 ++ "\n" ++ msgLine2;

        const win = self.vx.window();

        win.clear();

        self.vx.setMouseShape(.default);

        const child = win.child(.{
            .x_off = (win.width / 2) - 7,
            .y_off = win.height / 2 + 1,
            .width = .{ .limit = msgLine1.len },
            .height = .{ .limit = 2 },
        });

        const style: vaxis.Style = if (child.hasMouse(self.mouse)) |_| blk: {
            self.mouse = null;
            self.vx.setMouseShape(.pointer);
            break :blk .{ .reverse = true };
        } else .{};

        _ = try child.printSegment(.{ .text = msg, .style = style }, .{});
    }
};
