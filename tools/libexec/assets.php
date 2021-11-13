<?php
# The asset loader.


$sep = DIRECTORY_SEPARATOR;
$toolDirectory = __DIR__ . $sep . "..";
require_once $toolDirectory . $sep . "lib" . $sep . "utils.php";

$rootDirectory = __DIR__ . $sep . ".." . $sep . "..";
$assetDirectory = $rootDirectory . $sep . "assets";
$publicDirectory = $rootDirectory . $sep . "public";

$hasAsset = false;

$dirs = array();
array_push($dirs, $assetDirectory);

# Scan the directory of assets to check
#  whether any asset exists.
while (!$hasAsset && count($dirs) > 0) {
    $dir = array_pop($dirs);

    $files = scandir($dir);
    foreach ($files as $file) {
        # Skip private directories and files.
        if ("." == substr($file, 0, 1)) {
            continue;
        }

        $path = $dir . "/" . $file;
        if (is_dir($path)) {
            array_push($dirs, $path);
        }
        else if (file_exists($path)) {
            $hasAsset = true;
            break;
        }
    }
}

# Exit if no asset.
if (!$hasAsset) {
    exit(0);
}

# Save the path of old working directory.
$oldDirectory = getcwd();

# Move to root path of mdcms.
if (!chdir($rootDirectory)) {
    # Move back to old working directory.
    chdir($oldDirectory);

    fwrite(STDERR, "Unable to change working directory to root path of mdcms", PHP_EOL);
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
    # xCopy is a utility function in mdcms.
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
