#ifndef KEEPAWAKECHECKER_H
#define KEEPAWAKECHECKER_H

#include "keepAwakeHelper.h"


class KeepAwakeChecker : public QObject
{
    Q_OBJECT

public:
    KeepAwakeChecker();
    ~KeepAwakeChecker();
    Q_INVOKABLE void enable();
    Q_INVOKABLE void disable();

private:
    KeepAwakeHelper *keepAwakeHelper;
};

#endif // KEEPAWAKECHECKER_H
