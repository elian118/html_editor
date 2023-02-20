import React, { useState } from 'react';
import './App.css';
import TinyMceEditor from './common/components/TinyMceEditor';
import { Button, Dialog, DialogBody, DialogFooter, DialogHeader } from '@material-tailwind/react';
import { htmlText } from './common/rawData/htmlText';

const App = () => {
  const [open, setOpen] = useState<boolean>(false);
  const [content, setContent] = useState<string>('');

  const handleOpen = () => setOpen(!open);

  return (
    <div className="App">
      <TinyMceEditor
        text={content}
        setText={setContent}
        minHeight={500}
      />
      <div className="mt-4 grid gap-4 grid-cols-2">
        <Button
          variant="gradient"
          color="amber"
          onClick={handleOpen}
        >
          콘텐츠 소스코드 보기
        </Button>
        <Button
          variant="gradient"
          color="amber"
          onClick={() => setContent(htmlText)}
        >
          샘플 콘텐츠 입력
        </Button>
      </div>
      <Dialog open={open} handler={handleOpen} size={window.innerWidth > 1024 ? 'xl' : 'xxl'}>
        <DialogHeader>콘텐츠 소스 보기</DialogHeader>
        <DialogBody divider>
          <div className="h-96 overflow-auto">{content}</div>
        </DialogBody>
        <DialogFooter>
          <Button variant="gradient" color="green" onClick={handleOpen}>
            <span>확인</span>
          </Button>
        </DialogFooter>
      </Dialog>
    </div>
  )
}

export default App
