<?php

function getBranches(bool $includeMaster = false): array
{
    $raw = `git branch`;
    $data = array_filter(array_map(function (string $branch): string {
        return trim(str_replace('*', '', $branch));
    }, explode(PHP_EOL, $raw)));

    if (!$includeMaster) {
        $data = array_filter($data, function (string $branch): bool {
            return $branch !== 'master';
        });
    }

    return $data;
}

function getRemoteBranches(): array
{
    $raw = `git branch -a`;
    $data = array_filter(array_map(function (string $branch): string {
        return trim(str_replace('*', '', $branch));
    }, explode(PHP_EOL, $raw)));

    $data = array_filter($data, function (string $branch): bool {
        return fnmatch("remotes/origin/*", $branch);
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
