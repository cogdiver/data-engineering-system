locals {
  # Components that will use custom roles and managed identities
  iam_components = {
    "ui" = {
      "no_actions": [],
      "actions": [
        "Microsoft.Storage/storageAccounts/blobServices/read"
      ],
    },
    "backend" = {
      "no_actions": [],
      "actions": [
        "Microsoft.Storage/storageAccounts/blobServices/write"
      ],
    },
    "trigger" = {
      "no_actions": [],
      "actions": [
        "Microsoft.Storage/storageAccounts/blobServices/read"
      ],
    }
  }
}
