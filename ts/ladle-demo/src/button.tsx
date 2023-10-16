import React from "react";

/** https://gist.github.com/mujsdev/c58cfdfb566861d5efd9352523ce28fa */
export interface ButtonProps extends React.HTMLAttributes<HTMLButtonElement> {
  children: React.ReactNode;
  color: "black" | "white";
  size?: "sm";
  hasBorder?: boolean;
  disabled?: boolean;
  isLoading?: boolean;
}

export const Button = ({
  children,
  color = "black",
  size,
  hasBorder = false,
  disabled = false,
  isLoading = false,
  ...props
}: ButtonProps) => {
  const hasBorderClass = hasBorder && `btn--border`;
  const isLoadingClass = isLoading && `btn--loading`;
  const classNames = `btn btn--${color} btn--${size} ${hasBorderClass} ${isLoadingClass}`;

  return (
    <button className={classNames} {...props} disabled={disabled}>
      {children}
    </button>
  );
};