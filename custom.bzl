load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "tool",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

def _impl(ctx):
    target_cpu = "custom"
    toolchain_identifier = "custom_toolchain_identifier"
    target_system_name = "custom-unknown-unknown"
    target_libc = "musl/custom"
    compiler = "custom"
    compiler_tool = tool(tool = ctx.executable.compiler)

    c_compile_action = action_config(
        action_name = ACTION_NAMES.c_compile,
        tools = [compiler_tool],
    )

    action_configs = [
        c_compile_action,
    ]


    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        action_configs = action_configs,
        toolchain_identifier = toolchain_identifier,
        target_system_name = target_system_name,
        target_cpu = target_cpu,
        target_libc = target_libc,
        compiler = compiler,
    )


custom_cc_toolchain_config_rule = rule(
    implementation = _impl,
    attrs = {
        "compiler": attr.label(
            mandatory = True,
            executable = True,
            allow_files = True,
            cfg = "exec"
        ),
    },
    provides = [CcToolchainConfigInfo],
)
