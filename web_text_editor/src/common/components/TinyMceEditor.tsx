import React, { FC, useRef } from 'react';
import { Editor } from '@tinymce/tinymce-react';

type TinyMceEditorProps = {
  text: string;
  setText: (val: string) => void;
  width?: string | number;
  height?: string | number;
  minWidth?: number;
  maxWidth?: number;
  minHeight?: number;
  maxHeight?: number;
  placeHolder?: string;
};

const TinyMceEditor: FC<TinyMceEditorProps> = ({
  text,
  setText,
  width,
  height,
  minWidth,
  maxWidth,
  minHeight,
  maxHeight,
  placeHolder,
}) => {
  const fileInputRef = useRef<HTMLInputElement>(null);
  const getImgFile = (callback: any) => {
    let input = document.getElementById('myImg') as HTMLInputElement;
    if (!input) return;
    fileInputRef?.current?.click();

    input.onchange = () => {
      let file = (input as any)?.files[0];
      let reader = new FileReader();
      reader.onload = (e: ProgressEvent<FileReader>) => {
        callback((e.target as FileReader).result, {
          alt: file.name,
        });
      };
      reader.readAsDataURL(file);
    };
  };

  return (
    // Box sx prop => 특정 클래스에 스타일 오버라이드
    <>
      <Editor
        id="tinyEditor"
        apiKey="wlfrm00abx6123czz7qz4apohggod4b035ht5nqg3mz2so6c"
        value={text}
        init={{
          language: 'ko_KR', // 한글판 적용
          selector: '#default' as any,
          width: width ? width : undefined,
          height: height ? height : undefined,
          min_width: minWidth ? minWidth : undefined,
          min_height: minHeight ? minHeight : undefined,
          max_width: maxWidth ? maxWidth : undefined,
          max_height: maxHeight ? maxHeight : undefined,
          automatic_uploads: true,
          block_unsupported_drop: false,
          file_picker_types: 'image',
          file_picker_callback: (callback) => getImgFile(callback), // 파일 업로드
          font_formats:
            'Andale Mono=andale mono,times; ' +
            'Arial=arial,helvetica,sans-serif; ' +
            'Arial Black=arial black,avant garde; ' +
            'Book Antiqua=book antiqua,palatino; ' +
            'Comic Sans MS=comic sans ms,sans-serif; ' +
            'Courier New=courier new,courier; ' +
            'Georgia=georgia,palatino; ' +
            'Helvetica=helvetica; ' +
            'Impact=impact,chicago; ' +
            'Nanum Gothic=Nanum Gothic; ' +
            'Symbol=symbol; ' +
            'Tahoma=tahoma,arial,helvetica,sans-serif; ' +
            'Terminal=terminal,monaco; ' +
            'Times New Roman=times new roman,times; ' +
            'Trebuchet MS=trebuchet ms,geneva; ' +
            'Verdana=verdana,geneva; ' +
            'Webdings=webdings; ' +
            'Wingdings=wingdings,zapf dingbats',
          content_style:
            "@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');" +
            'body { font-family: Nanum Gothic; }',
          menubar: false,
          toolbar_mode: 'floating',
          plugins: [
            'advlist',
            'autolink',
            'link',
            'image',
            'lists',
            'charmap',
            'preview',
            'anchor',
            'pagebreak',
            'searchreplace',
            'wordcount',
            'visualblocks',
            'visualchars',
            'code',
            'fullscreen',
            'insertdatetime',
            'media',
            'table',
            'emoticons',
            'template',
            'preview'
            // 'help',
          ],
          table_appearance_options: true,
          toolbar: [
            { name: 'fontBody', items: ['fontfamily', 'fontsize'] },
            {
              name: 'fontStyle',
              items: ['bold', 'underline', 'italic', 'strikethrough'],
            },
            { name: 'fontColor', items: ['forecolor', 'backcolor'] },
            {
              name: 'align',
              items: ['alignleft', 'aligncenter', 'alignright', 'alignjustify'],
            },
            { name: 'list', items: ['numlist', 'bullist'] },
            { name: 'dent', items: ['outdent', 'indent'] },
            { name: 'pagebreak', items: ['pagebreak', 'preview'] },
            { name: 'upload', items: ['link', 'image', 'media', 'table'] },
          ],
          placeholder: placeHolder ? placeHolder : undefined,
          statusbar: false, // 하단 상태바 생략
          branding: false, // 하단 상태바 TinyMCE 상호명 생략
          elementpath: false, // 하단 상태바 에디터 래퍼 태그정보 생략
          resize: false, // 하단 상태바에 있는 편집기 사이즈 조정 기본기능 비활성화
        }}
        onEditorChange={setText}
      />
      <input
        id="myImg"
        ref={fileInputRef}
        accept="image/*"
        type="file"
        style={{ display: 'none' }}
      />
    </>
  );
};

export default TinyMceEditor; // vite 에서 TinyMCE 는 export default 만 허용한다.
