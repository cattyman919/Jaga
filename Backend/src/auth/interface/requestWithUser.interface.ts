
export default interface requestWithUser extends Request {
  user: {
    id?: number;
    username?: string;
    sub?: string;
  };
}
