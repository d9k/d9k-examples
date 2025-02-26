import type { Meta } from '@storybook/react';
// import type { Meta, StoryObj } from '@storybook/react';
// import { TimerNoDeps } from './TestUseEffectCountNoDeps';
// import sourceCode from './TestUseEffectCountNoDeps.tsx?inline';
import React from 'react';

const meta = {
  title: 'UseEffect/CountNoDeps',
  // component: TimerNoDeps,
  // parameters: {
  //   source: {
  //     code: sourceCode,
  //   },
  // },
// } satisfies Meta<typeof TimerNoDeps>;
} satisfies Meta;

export default meta;

// type Story = StoryObj<typeof meta>;
// export const Default: Story = {};

export const TimerNoDepsComponent = () => {
    const [count, setCount] = React.useState(0);
    const logPrefix = 'TestUseEffectCountNoDeps:';

    React.useEffect(() => {
        const id = setInterval(() => {
            setCount(count + 1);
        }, 1000);
        return () => clearInterval(id);
    }, []);
    // test comment 1
    /* test comment 2 */
    console.log(logPrefix, count);

    return (<h1>{count}</h1>);
}
