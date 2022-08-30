fn main() -> Result<(), Box<dyn std::error::Error>> {
    // We can iterate over directories and match files with .proto extension instead of hardcoding it
    // We can also get the ../.. directory via Bazel's make variables and pass it as build ENV variable
    tonic_build::configure()
        .build_server(false)
        .compile(
            &[
                "cluster/cluster_database.proto",
                "cluster/cluster_server.proto",
                "cluster/cluster_service.proto",
                "cluster/cluster_user.proto",
                "core/core_service.proto",
                "core/core_database.proto",
                "common/answer.proto",
                "common/concept.proto",
                "common/logic.proto",
                "common/options.proto",
                "common/query.proto",
                "common/session.proto",
                "common/transaction.proto"
            ],
            &[
                "../../"
            ],
        )?;
    Ok(())
}
