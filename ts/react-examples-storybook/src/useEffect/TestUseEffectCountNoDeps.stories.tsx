import type { Meta, StoryObj } from '@storybook/react';
import { TestUseEffectCountNoDeps } from './TestUseEffectCountNoDeps';

const meta = {
  title: 'UseEffect/CountNoDeps',
  component: TestUseEffectCountNoDeps,
} satisfies Meta<typeof TestUseEffectCountNoDeps>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Default: Story = {};
