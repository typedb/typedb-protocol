def decompose_targets(list_of_targets):
    output = []
    for target in list_of_targets:
        output += target.files.to_list()
    return output

def _ts_grpc_compile_impl(ctx):
    print(ctx.attr._compiler)
    print(ctx.attr._plugin)
    print(ctx.attr._plugin.files.to_list())
    print(decompose_targets(ctx.attr.srcs))
    output_directory = ctx.actions.declare_directory(ctx.attr.name)
    output_directory2 = ctx.actions.declare_file("file.txt")
    ctx.actions.run(
        executable = ctx.executable._compiler,
        inputs = decompose_targets(ctx.attr.srcs) + ctx.attr._plugin.files.to_list(),
        outputs = [ output_directory ],
        arguments = [
            "--plugin='protoc-gen-ts=$(location @npm//grpc_tools_node_protoc_ts/bin:protoc-gen-ts)",
            "--js_out='import_style=es6,binary:$(@D)/'",
            "--ts_out='binary:$(@D)/'",
            "--proto_path=.",
            "./*.proto"
        ]
    )
    ctx.actions.run_shell(
        command = "ls",
        outputs = [ output_directory2 ],
        arguments = [ "-al > file.txt" ],
    )
    print(ctx.bin_dir.path)

ts_grpc_compile = rule(
    implementation = _ts_grpc_compile_impl,
    attrs = {
        "srcs": attr.label_list(),
        "_compiler": attr.label(
            executable = True,
            cfg="exec",
            default="@npm//grpc-tools/bin:grpc_tools_node_protoc",
        ),
        "_plugin": attr.label(
            default="@npm//grpc_tools_node_protoc_ts/bin:protoc-gen-ts",
        ),
    },

)