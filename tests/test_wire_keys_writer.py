from wire_keys import is_key_name, models_url, writer_kind, writer_ok, writer_probe_argv


def test_grok_probe_argv():
    kind, argv = writer_probe_argv("/Users/x/.grok/bin/grok")
    assert kind == "grok"
    assert argv == ["/Users/x/.grok/bin/grok", "models"]


def test_grok_agent_symlink():
    kind, argv = writer_probe_argv("/Users/x/.grok/bin/agent")
    assert kind == "grok"
    assert argv[-1] == "models"


def test_path_agent_refused():
    kind, argv = writer_probe_argv("/usr/local/bin/agent")
    assert kind == "path-agent"
    assert argv is None


def test_codex_login_status():
    kind, argv = writer_probe_argv("/Applications/ChatGPT.app/Contents/Resources/codex")
    assert kind == "codex"
    assert argv[-2:] == ["login", "status"]


def test_claude_auth_status():
    kind, argv = writer_probe_argv("/opt/homebrew/bin/claude")
    assert kind == "claude"
    assert argv[-2:] == ["auth", "status"]


def test_opencode_auth_list():
    kind, argv = writer_probe_argv("/opt/homebrew/bin/opencode")
    assert kind == "opencode"
    assert argv[-2:] == ["auth", "list"]


def test_kimi_auth_status():
    kind, argv = writer_probe_argv("/opt/homebrew/bin/kimi")
    assert kind == "kimi"
    assert argv[-2:] == ["auth", "status"]


def test_writer_ok_kind():
    assert writer_ok("grok:ok")
    assert writer_ok("opencode:ok")
    assert writer_ok("cursor:ok")
    assert writer_kind("claude:ok") == "claude"
    assert not writer_ok("cursor:unauth")
    assert not writer_ok("path-agent")


def test_key_names():
    assert is_key_name("OPENROUTER_API_KEY")
    assert is_key_name("GEMINI_API_KEY")
    assert is_key_name("HF_TOKEN")
    assert is_key_name("FOO_API_TOKEN")
    assert not is_key_name("OPENAI_BASE_URL")
    assert not is_key_name("AWS_ACCESS_KEY_ID")


def test_models_url_named_and_compat():
    extra = {}
    assert models_url("OPENROUTER_API_KEY", extra).endswith("/api/v1/models")
    assert models_url("DEEPSEEK_API_KEY", extra).endswith("/models")
    assert models_url("CUSTOM_API_KEY", extra) is None
    assert (
        models_url("CUSTOM_API_KEY", {"OPENAI_BASE_URL": "https://api.example.com/v1"})
        == "https://api.example.com/v1/models"
    )
    assert models_url("ANTHROPIC_API_KEY", extra) is None
    assert (
        models_url("OPENAI_API_KEY", {"OPENAI_BASE_URL": "https://api.groq.com/openai/v1"})
        == "https://api.groq.com/openai/v1/models"
    )
