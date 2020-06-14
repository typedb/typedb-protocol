# Do not edit. bazel-deps autogenerates this file from dependencies/maven/dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "com.google.android:annotations:4.1.1.4", "lang": "java", "sha1": "a1678ba907bf92691d879fef34e1a187038f9259", "sha256": "ba734e1e84c09d615af6a09d33034b4f0442f8772dec120efb376d86a565ae15", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/android/annotations/4.1.1.4/annotations-4.1.1.4.jar", "source": {"sha1": "deb22daeb37bdcbc14230aeaeddce38320d6d0f9", "sha256": "e9b667aa958df78ea1ad115f7bbac18a5869c3128b1d5043feb360b0cfce9d40", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/android/annotations/4.1.1.4/annotations-4.1.1.4-sources.jar"} , "name": "com-google-android-annotations", "actual": "@com-google-android-annotations//jar", "bind": "jar/com/google/android/annotations"},
    {"artifact": "com.google.api.grpc:proto-google-common-protos:1.17.0", "lang": "java", "sha1": "40471bf2045151c17da555889b5550fcfd5224a8", "sha256": "ad25472c73ee470606fb500b376ae5a97973d5406c2f5c3b7d07fb25b4648b65", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.17.0/proto-google-common-protos-1.17.0.jar", "source": {"sha1": "6412bec508c9e38064d5f47024e6ee4de8dc82b6", "sha256": "7a0128ee3a58953ed8f30828812d9ac54c10f36494fc9eed88a5398c23c29c85", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.17.0/proto-google-common-protos-1.17.0-sources.jar"} , "name": "com-google-api-grpc-proto-google-common-protos", "actual": "@com-google-api-grpc-proto-google-common-protos//jar", "bind": "jar/com/google/api/grpc/proto-google-common-protos"},
# duplicates in com.google.code.findbugs:jsr305 promoted to 3.0.2
# - com.google.guava:guava:23.0 wanted version 1.3.9
# - io.grpc:grpc-api:1.29.0 wanted version 3.0.2
# - io.perfmark:perfmark-api:0.19.0 wanted version 3.0.2
    {"artifact": "com.google.code.findbugs:jsr305:3.0.2", "lang": "java", "sha1": "25ea2e8b0c338a877313bd4672d3fe056ea78f0d", "sha256": "766ad2a0783f2687962c8ad74ceecc38a28b9f72a2d085ee438b7813e928d0c7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar", "source": {"sha1": "b19b5927c2c25b6c70f093767041e641ae0b1b35", "sha256": "1c9e85e272d0708c6a591dc74828c71603053b48cc75ae83cce56912a2aa063b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2-sources.jar"} , "name": "com-google-code-findbugs-jsr305", "actual": "@com-google-code-findbugs-jsr305//jar", "bind": "jar/com/google/code/findbugs/jsr305"},
    {"artifact": "com.google.code.gson:gson:2.8.6", "lang": "java", "sha1": "9180733b7df8542621dc12e21e87557e8c99b8cb", "sha256": "c8fb4839054d280b3033f800d1f5a97de2f028eb8ba2eb458ad287e536f3f25f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.8.6/gson-2.8.6.jar", "source": {"sha1": "1b9adea7bbe0b251818f42fde0bd2988d7e5f20a", "sha256": "da4d787939dc8de214724a20d88614b70ef8c3a4931d9c694300b5d9098ed9bc", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.8.6/gson-2.8.6-sources.jar"} , "name": "com-google-code-gson-gson", "actual": "@com-google-code-gson-gson//jar", "bind": "jar/com/google/code/gson/gson"},
# duplicates in com.google.errorprone:error_prone_annotations promoted to 2.3.4
# - com.google.guava:guava:23.0 wanted version 2.0.18
# - io.grpc:grpc-api:1.29.0 wanted version 2.3.4
# - io.grpc:grpc-core:1.29.0 wanted version 2.3.4
    {"artifact": "com.google.errorprone:error_prone_annotations:2.3.4", "lang": "java", "sha1": "dac170e4594de319655ffb62f41cbd6dbb5e601e", "sha256": "baf7d6ea97ce606c53e11b6854ba5f2ce7ef5c24dddf0afa18d1260bd25b002c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4.jar", "source": {"sha1": "950adf6dcd7361e3d1e544a6e13b818587f95d14", "sha256": "0b1011d1e2ea2eab35a545cffd1cff3877f131134c8020885e8eaf60a7d72f91", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4-sources.jar"} , "name": "com-google-errorprone-error_prone_annotations", "actual": "@com-google-errorprone-error_prone_annotations//jar", "bind": "jar/com/google/errorprone/error-prone-annotations"},
    {"artifact": "com.google.guava:guava:23.0", "lang": "java", "sha1": "c947004bb13d18182be60077ade044099e4f26f1", "sha256": "7baa80df284117e5b945b19b98d367a85ea7b7801bd358ff657946c3bd1b6596", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/23.0/guava-23.0.jar", "source": {"sha1": "ed233607c5c11e1a13a3fd760033ed5d9fe525c2", "sha256": "37fe8ba804fb3898c3c8f0cbac319cc9daa58400e5f0226a380ac94fb2c3ca14", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/23.0/guava-23.0-sources.jar"} , "name": "com-google-guava-guava", "actual": "@com-google-guava-guava//jar", "bind": "jar/com/google/guava/guava"},
    {"artifact": "com.google.j2objc:j2objc-annotations:1.3", "lang": "java", "sha1": "ba035118bc8bac37d7eff77700720999acd9986d", "sha256": "21af30c92267bd6122c0e0b4d20cccb6641a37eaf956c6540ec471d584e64a7b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar", "source": {"sha1": "d26c56180205cbb50447c3eca98ecb617cf9f58b", "sha256": "ba4df669fec153fa4cd0ef8d02c6d3ef0702b7ac4cabe080facf3b6e490bb972", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3-sources.jar"} , "name": "com-google-j2objc-j2objc-annotations", "actual": "@com-google-j2objc-j2objc-annotations//jar", "bind": "jar/com/google/j2objc/j2objc-annotations"},
    {"artifact": "com.google.protobuf:protobuf-java:3.5.1", "lang": "java", "sha1": "8c3492f7662fa1cbf8ca76a0f5eb1146f7725acd", "sha256": "b5e2d91812d183c9f053ffeebcbcda034d4de6679521940a19064714966c2cd4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1.jar", "source": {"sha1": "7235a28a13938050e8cd5d9ed5133bebf7a4dca7", "sha256": "3be3115498d543851443bfa725c0c5b28140e363b3b7dec97f4028cd17040fa4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1-sources.jar"} , "name": "com-google-protobuf-protobuf-java", "actual": "@com-google-protobuf-protobuf-java//jar", "bind": "jar/com/google/protobuf/protobuf-java"},
# duplicates in io.grpc:grpc-api fixed to 1.29.0
# - io.grpc:grpc-core:1.29.0 wanted version [1.29.0]
# - io.grpc:grpc-protobuf-lite:1.29.0 wanted version 1.29.0
# - io.grpc:grpc-protobuf:1.29.0 wanted version 1.29.0
# - io.grpc:grpc-stub:1.29.0 wanted version 1.29.0
    {"artifact": "io.grpc:grpc-api:1.29.0", "lang": "java", "sha1": "04f067a7b1657ad95c00fe958e8a66c8f8446c9f", "sha256": "4837824acdd8d576d7d31a862e7391c38a1824cd2224daa68999377fdff9ae3f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-api/1.29.0/grpc-api-1.29.0.jar", "source": {"sha1": "fd872828400620c57afe4685753cd75db763ea39", "sha256": "f9265d8b37d4b35fa6184be21a5b5975246198ab730beaf4efec459cade14f5b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-api/1.29.0/grpc-api-1.29.0-sources.jar"} , "name": "io-grpc-grpc-api", "actual": "@io-grpc-grpc-api//jar", "bind": "jar/io/grpc/grpc-api"},
    {"artifact": "io.grpc:grpc-context:1.29.0", "lang": "java", "sha1": "1d8a441110f86f8927543dc3007639080441ea3c", "sha256": "41426f8fa5b5ff6e8cf5d6a7a6e7b1175350bc8c8e11f352e0622e00f99c4a02", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.29.0/grpc-context-1.29.0.jar", "source": {"sha1": "9be4b89f1140e9dbb084f793627f76ee8ad47b46", "sha256": "56552f0eab62fd8fa770908b0e88e1313474f1a0372cd32ec210f45e9fa2079e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.29.0/grpc-context-1.29.0-sources.jar"} , "name": "io-grpc-grpc-context", "actual": "@io-grpc-grpc-context//jar", "bind": "jar/io/grpc/grpc-context"},
    {"artifact": "io.grpc:grpc-core:1.29.0", "lang": "java", "sha1": "b051a14a67c97bb9bbe0b9a03b5d7e7080e7b960", "sha256": "d45e3ba310cf6a5d8170bcc500507977505614583c341d03c7d91658e49cf028", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.29.0/grpc-core-1.29.0.jar", "source": {"sha1": "236040aa86f3bf7b44785d48670007ea2b28eb56", "sha256": "c96e39670a2bc73e572f4af090bd9ff55528b07220363d75761beb999efbd7f8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.29.0/grpc-core-1.29.0-sources.jar"} , "name": "io-grpc-grpc-core", "actual": "@io-grpc-grpc-core//jar", "bind": "jar/io/grpc/grpc-core"},
    {"artifact": "io.grpc:grpc-protobuf-lite:1.29.0", "lang": "java", "sha1": "22e5ff00b942ee573c9dbadfc5e690b151a6d5e4", "sha256": "ae4bbcd9bf7ad4856660807d8cba7ef4ff428f0b615bf663ba308d9a76bcab3c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.29.0/grpc-protobuf-lite-1.29.0.jar", "source": {"sha1": "a2892eadac6efb349027cbd3ad5c6f4d1cededf8", "sha256": "d5cf99972b626478b0b9b6bf767e590c910e399a8dcd47c98aa7f9d67f0ea772", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.29.0/grpc-protobuf-lite-1.29.0-sources.jar"} , "name": "io-grpc-grpc-protobuf-lite", "actual": "@io-grpc-grpc-protobuf-lite//jar", "bind": "jar/io/grpc/grpc-protobuf-lite"},
    {"artifact": "io.grpc:grpc-protobuf:1.29.0", "lang": "java", "sha1": "57a50ff72c0da333c31ad45616ea17f7d3b91b1c", "sha256": "ee8cef64c7e10dd373aabd3a4b2ec4878e6d5b3ba43cbf55f3876ddaa79266ea", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.29.0/grpc-protobuf-1.29.0.jar", "source": {"sha1": "87f31a3d9abe1a973e83211b1340042ac56f9727", "sha256": "0c1f5e07b28f0deb5d85d87738be0b545407d613affdb0031d6f0839d1eb2ff2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.29.0/grpc-protobuf-1.29.0-sources.jar"} , "name": "io-grpc-grpc-protobuf", "actual": "@io-grpc-grpc-protobuf//jar", "bind": "jar/io/grpc/grpc-protobuf"},
    {"artifact": "io.grpc:grpc-stub:1.29.0", "lang": "java", "sha1": "2ded7df15689f2e606189456a91f7a9e1da9feee", "sha256": "65b01e451013d6c9f2de1392abf47190a397cbbd7f5a45e3cc9df509671a0cf8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.29.0/grpc-stub-1.29.0.jar", "source": {"sha1": "4e249ea8ebbe9fee84c0e32041c1d5c8df8909bb", "sha256": "fdb6c4eaa76481c6166901bc2cd324c8027538fae6b36572b331bc629914e2cd", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.29.0/grpc-stub-1.29.0-sources.jar"} , "name": "io-grpc-grpc-stub", "actual": "@io-grpc-grpc-stub//jar", "bind": "jar/io/grpc/grpc-stub"},
    {"artifact": "io.perfmark:perfmark-api:0.19.0", "lang": "java", "sha1": "2bfc352777fa6e27ad1e11d11ea55651ba93236b", "sha256": "b734ba2149712409a44eabdb799f64768578fee0defe1418bb108fe32ea43e1a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/perfmark/perfmark-api/0.19.0/perfmark-api-0.19.0.jar", "source": {"sha1": "ca61d9fa052fd1caef7ccadd9b35fca7cc9184a1", "sha256": "05cfbdd34e6fc1f10181c755cec67cf1ee517dfee615e25d1007a8aabd569dba", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/perfmark/perfmark-api/0.19.0/perfmark-api-0.19.0-sources.jar"} , "name": "io-perfmark-perfmark-api", "actual": "@io-perfmark-perfmark-api//jar", "bind": "jar/io/perfmark/perfmark-api"},
# duplicates in org.codehaus.mojo:animal-sniffer-annotations promoted to 1.18
# - com.google.guava:guava:23.0 wanted version 1.14
# - io.grpc:grpc-api:1.29.0 wanted version 1.18
    {"artifact": "org.codehaus.mojo:animal-sniffer-annotations:1.18", "lang": "java", "sha1": "f7aa683ea79dc6681ee9fb95756c999acbb62f5d", "sha256": "47f05852b48ee9baefef80fa3d8cea60efa4753c0013121dd7fe5eef2e5c729d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.18/animal-sniffer-annotations-1.18.jar", "source": {"sha1": "0dff084acf1ff3ff9145b1708c566787d2c82dd0", "sha256": "ee078a91bf7136ee1961abd612b54d1cd9877352b960a7e1e7e3e4c17ceafcf1", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.18/animal-sniffer-annotations-1.18-sources.jar"} , "name": "org-codehaus-mojo-animal-sniffer-annotations", "actual": "@org-codehaus-mojo-animal-sniffer-annotations//jar", "bind": "jar/org/codehaus/mojo/animal-sniffer-annotations"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
