import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ToolbarWebComponent } from './toolbar-web.component';

describe('ToolbarWebComponent', () => {
  let component: ToolbarWebComponent;
  let fixture: ComponentFixture<ToolbarWebComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ToolbarWebComponent],
    }).compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ToolbarWebComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
