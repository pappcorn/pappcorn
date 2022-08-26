import { Figure } from './figure.interface';

export interface Album {
  dates: {
    start: number;
    lastUpdate: number;
    end?: number;
  };
  managers: Record<string, OwnerRol>;
  name: string;
  owner: string;
  key: string;
  figures: Figure[];
}

export enum OwnerRol {
  ADMIN = 'amdin',
  VIEWER = 'viewer',
  CREATOR = 'creator',
}
