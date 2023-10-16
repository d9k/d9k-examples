import React from "react"
import type {Story} from "@ladle/react"

import {Button} from "./button"

type StoryProps = {
  children: string
  color: "black" | "white"
  disabled?: boolean
  hasBorder?: boolean
  isLoading?: boolean
};

export const ButtonStory: Story<StoryProps> = ({
  children,
  color,
  disabled,
  hasBorder,
  isLoading
}) => {
  return (
    <div>
      <h3>Button</h3>
      <Button
        color={color}
        disabled={disabled}
        hasBorder={hasBorder}
        isLoading={isLoading}
      >
        {children}
      </Button>
    </div>
  )
}

ButtonStory.args = {
  color: "black",
  children: 'Push me',
  disabled: false,
  hasBorder: false,
  isLoading: false,
}

ButtonStory.argTypes = {
  color: {
    control: {type: "radio"},
    options: [
      "black",
      "white"
    ],
  }
}