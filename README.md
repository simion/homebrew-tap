# simion's Homebrew tap

```sh
brew install --cask simion/tap/termic   # Termic, https://termic.dev
brew install simion/tap/xkill           # xkill for macOS, https://github.com/simion/xkill
```

Each command taps this repo and installs in one step.
`brew upgrade` keeps them current.

## What is here

- `Casks/termic.rb`: [Termic](https://github.com/simion/termic), the signed and notarized macOS app.
  The same cask is also in [simion/homebrew-termic](https://github.com/simion/homebrew-termic), so `brew install --cask simion/termic/termic` keeps working.
- `Formula/xkill.rb`: [xkill](https://github.com/simion/xkill), click a window to force-kill its app. Built from source; bumped automatically by xkill's release workflow.
