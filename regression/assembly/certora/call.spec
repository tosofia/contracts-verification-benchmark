rule call {
    env e;
    address a;
    address to;
    require(e.msg.value == 0);
    require(e.msg.sender != 0);

    bool success = f_wrap(e, a, to);

    assert(success);
}