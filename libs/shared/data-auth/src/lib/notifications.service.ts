import { Injectable } from '@angular/core';

import { BehaviorSubject } from 'rxjs';

export interface Notification {
  message: string;
  action?: string;
  duration?: number;
  type: 'success' | 'error' | 'info';
}
@Injectable({ providedIn: 'root' })
export class NotificationsService {
  private _notify = new BehaviorSubject<Notification>({} as Notification);
  public notify$ = this._notify.asObservable();

  showSuccess(message: string, action: string = 'OK', duration: number = 3000) {
    this._notify.next({ message, action, duration, type: 'success' });
  }
  showError(message: string, action: string = 'OK', duration: number = 3000) {
    this._notify.next({ message, action, duration, type: 'error' });
  }
}
