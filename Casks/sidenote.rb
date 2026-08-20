cask "sidenote" do
  version "0.1.0"
  sha256 "0ab8089e8cfd7a6fe0f24f585cedd6a64837d7a916f0b7a58f7997bc15d7112d"

  url "https://github.com/benedictshegog/sidenote/releases/download/v#{version}/Sidenote_#{version}_aarch64.dmg"
  name "Sidenote"
  desc "Review markdown written by Claude Code: WYSIWYG editing, comments, replies in place"
  homepage "https://github.com/benedictshegog/sidenote"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Sidenote.app"
  binary "#{appdir}/Sidenote.app/Contents/MacOS/sidenote"

  zap trash: [
    "~/.sidenote",
    "~/.claude/skills/sidenote-review",
  ]
end
