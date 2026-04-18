import io
from unittest.mock import MagicMock, patch
from src.module_types.cluster import write_tests


def call_write_tests(**getter_returns):
    buf = io.StringIO()
    cursor = MagicMock()

    defaults = dict(
        tablespaces_are=[],
        roles_are=[],
        groups_are=[],
        users_are=[],
        languages_are=[],
        casts_are=[],
    )
    defaults.update(getter_returns)

    with (
        patch("src.module_types.cluster.get_tablespaces_are", return_value=defaults["tablespaces_are"]),
        patch("src.module_types.cluster.get_roles_are", return_value=defaults["roles_are"]),
        patch("src.module_types.cluster.get_groups_are", return_value=defaults["groups_are"]),
        patch("src.module_types.cluster.get_users_are", return_value=defaults["users_are"]),
        patch("src.module_types.cluster.get_languages_are", return_value=defaults["languages_are"]),
        patch("src.module_types.cluster.get_casts_are", return_value=defaults["casts_are"]),
    ):
        write_tests(buf, cursor)

    return buf.getvalue()


def test_output_starts_with_begin():
    assert call_write_tests().startswith("BEGIN;\n")


def test_output_ends_with_rollback():
    assert call_write_tests().endswith("ROLLBACK;\n")


def test_tablespaces_are_written_with_data():
    out = call_write_tests(tablespaces_are=["pg_default", "pg_global"])
    assert "SELECT tablespaces_are(" in out
    assert "'pg_default'" in out


def test_roles_are_written_with_data():
    out = call_write_tests(roles_are=["alice", "bob"])
    assert "SELECT roles_are(" in out
    assert "'alice'" in out


def test_users_are_written_with_data():
    out = call_write_tests(users_are=["alice"])
    assert "SELECT users_are(" in out
    assert "'alice'" in out


def test_languages_are_written_with_data():
    out = call_write_tests(languages_are=["plpgsql", "sql"])
    assert "SELECT languages_are(" in out
    assert "'plpgsql'" in out


def test_groups_are_written_with_data():
    out = call_write_tests(groups_are=["grp_readonly"])
    assert "SELECT groups_are(" in out
    assert "'grp_readonly'" in out


def test_casts_are_written_with_data():
    out = call_write_tests(casts_are=["(integer AS text)"])
    assert "SELECT casts_are(" in out
    assert "'(integer AS text)'" in out
