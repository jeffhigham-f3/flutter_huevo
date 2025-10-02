export type CallableResponse = {
    status: number;
    error?: string;
    data?: object;
}

export const isNonEmptyString = (value: unknown): boolean => {
    return typeof value === "string" && value.length > 0;
};

export const isNonEmptyStringArray = (value: unknown): boolean => {
    return Array.isArray(value) &&
        value.every((item) => isNonEmptyString(item));
};

export const isEnumArray = <T>(
    value: unknown,
    enumObject: Record<string, T>
): value is T[] => {
    if (!Array.isArray(value)) {
        return false;
    }

    const enumValues = Object.values(enumObject);
    return value.every((item) => enumValues.includes(item));
};
