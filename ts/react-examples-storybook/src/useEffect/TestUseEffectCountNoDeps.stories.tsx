import type { Meta } from '@storybook/react';
import React from 'react';

const meta = {
  title: 'UseEffect/CountNoDeps',
} satisfies Meta;

export default meta;

const SeeActionsPanelNote = () => {
  return <p>[See StoryBook Actions panel]</p>;
};

export const TimerNoDeps = () => {
  const [count, setCount] = React.useState(0);
  const logPrefix = 'TimerNoDeps:';

  React.useEffect(() => {
    const id = setInterval(() => {
      console.log(logPrefix, 'setInterval: run');
      setCount(count + 1);
    }, 1000);
    console.log(logPrefix, 'effect: run');
    return () => {
      clearInterval(id);
      console.log(logPrefix, 'effect: clean up');
    };
  }, []);

  console.log(logPrefix, 'count:', count);

  return <h1>{count}</h1>;
};

export const TimerNoDepsFixed = () => {
  const [count, setCount] = React.useState(0);
  const logPrefix = 'TimerNoDepsFixed:';

  React.useEffect(() => {
    const id = setInterval(() => {
      console.log(logPrefix, 'setInterval: run');
      setCount((count) => count + 1);
    }, 1000);
    console.log(logPrefix, 'effect: run');
    return () => {
      clearInterval(id);
      console.log(logPrefix, 'effect: clean up');
    };
  }, []);

  console.log(logPrefix, 'count:', count);

  return <h1>{count}</h1>;
};

export const FlagDep = () => {
  const [flag, setFlag] = React.useState(false);
  const logPrefix = 'FlagDep:';

  console.log(logPrefix, 'render: code before effect');

  React.useEffect(() => {
    setFlag(true);
    console.log(logPrefix, 'effect: run');
    return () => console.log(logPrefix, 'effect: clean up');
  }, [flag]);

  console.log(logPrefix, 'render: code after effect');

  return <SeeActionsPanelNote />;
};
