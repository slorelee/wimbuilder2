var $patches_preset = 'default';

if (fso.FileExists(project.full_path + '/_Assets_/preset/custom.js')) {
    $patches_preset = 'custom';
}

// $patches_preset = 'lite';

