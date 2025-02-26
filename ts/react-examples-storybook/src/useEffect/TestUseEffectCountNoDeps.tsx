import React from 'react';

export const TestUseEffectCountNoDeps: React.FC = () => {
    const [count, setCount] = React.useState(0);
    const logPrefix = 'TestUseEffectCountNoDeps:';

    React.useEffect(() => {
        const id = setInterval(() => {
            setCount(count + 1);
        }, 1000);
        return () => clearInterval(id);
    }, []);

    console.log(logPrefix, count);

    return (<hl>{count}</hl>);
}