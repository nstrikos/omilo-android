#include "keepAwakeChecker.h"

KeepAwakeChecker::KeepAwakeChecker()
{
    keepAwakeHelper = nullptr;
}

KeepAwakeChecker::~KeepAwakeChecker()
{
    if (keepAwakeHelper != nullptr)
        delete keepAwakeHelper;
}

void KeepAwakeChecker::enable()
{
    if (keepAwakeHelper != nullptr)
        delete keepAwakeHelper;
    keepAwakeHelper = new KeepAwakeHelper();
}

void KeepAwakeChecker::disable()
{
    if (keepAwakeHelper != nullptr)
        delete keepAwakeHelper;
}
