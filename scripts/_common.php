<?php

function getBranches(bool $includeMaster = false): array
{
    $raw = `git branch`;
    $data = array_filter(array_map(function (string $branch): string {
        return trim(str_replace('*', '', $branch));
    }, explode(PHP_EOL, $raw)));


    $data = array_filter($data, function (string $branch) use($includeMaster) {
        return fnmatch('v*.*.*', $branch) || ($includeMaster && $branch === 'master');
    });

    return $data;
}

function getRemoteBranches(): array
{
    $raw = `git branch -a`;
    $data = array_filter(array_map(function (string $branch): string {
        return trim(str_replace('*', '', $branch));
    }, explode(PHP_EOL, $raw)));

    $data = array_filter($data, function (string $branch): bool {
        return fnmatch("remotes/origin/*", $branch) && !fnmatch('remotes/origin/HEAD*', $branch);
    });

    return $data;
}

function trackAllBranches()
{
    $localBranches = getBranches(true);
    foreach (getRemoteBranches() as $branch) {
        $local = str_replace('remotes/origin/', '', $branch);
        if (!in_array($local, $localBranches, true)) {
            passthru("git branch --track {$local} {$branch}");
        }
    }
}

function lastArrayElement(array $array)
{
    return end($array);
}

function lastArrayKey(array $array)
{
    if (function_exists('array_key_last')) {
        /** @noinspection PhpElementIsNotAvailableInCurrentPhpVersionInspection */
        return array_key_last($array);
    }

    $keys = array_keys($array);
    return end($keys);
}