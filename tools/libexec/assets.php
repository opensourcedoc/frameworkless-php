<?php
# The asset loader.


$sep = DIRECTORY_SEPARATOR;
$toolDirectory = __DIR__ . $sep . "..";
require_once $toolDirectory . $sep . "lib" . $sep . "utils.php";

$rootDirectory = __DIR__ . $sep . ".." . $sep . "..";
$assetDirectory = $rootDirectory . $sep . "assets";
$publicDirectory = $rootDirectory . $sep . "public";

# Save the path of old working directory.
$oldDirectory = getcwd();

# Move to the root path.
if (!chdir($rootDirectory)) {
    # Move back to old working directory.
    chdir($oldDirectory);

    fwrite(STDERR, "Unable to change working directory to the root path", PHP_EOL);
    exit(1);
}

# We don't update NPM packages because they are merely for build automation.
if (!(file_exists("node_modules") && is_dir("node_modules"))) {
    if (!system("npm install")) {
        # Move back to old working directory.
        chdir($oldDirectory);

        fwrite(STDERR, "Unable to install NPM packages", PHP_EOL);
        exit(1);
    }
}

# Compile assets.
#
# Not every theme invoke the same command to compile assets.
#  Modify it according to your own situation.
if (!system("npm run prod")) {
    # Move back to old working directory.
    chdir($oldDirectory);

    fwrite(STDERR, "Unable to compile assets", PHP_EOL);
    exit(1);
}

# Copy assets recursively.
try {
    # xCopy is a utility function.
    #  It will copy directories and files recursively.
    xCopy($assetDirectory, $publicDirectory);
}
catch (Exception $e) {
    # Move back to old working directory.
    chdir($oldDirectory);

    fwrite(STDERR, "Unable to copy assets", PHP_EOL);
    exit(1);
}

# Move back to old working directory.
chdir($oldDirectory);
